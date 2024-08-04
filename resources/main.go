package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/Kagami/go-face"
)

// Path to directory with models and test images.
const dataDir = "testdata"

var (
	modelsDir = filepath.Join(dataDir, "models")
	imagesDir = filepath.Join(dataDir, "images")
)

func main() {
	// Init the recognizer.
	rec, err := face.NewRecognizer(modelsDir)
	if err != nil {
		log.Fatalf("Can't init face recognizer: %v", err)
	}
	defer rec.Close()

	// Test image.
	testImagePristin := filepath.Join(imagesDir, "co.jpg")
	faces, err := rec.RecognizeFile(testImagePristin)
	if err != nil {
		log.Fatalf("Can't recognize: %v", err)
	}

	// Assign names to the detected faces.
	var samples []face.Descriptor
	var cats []int32
	for i, f := range faces {
		samples = append(samples, f.Descriptor)
		cats = append(cats, int32(i))
	}

	labels := []string{
		"no-se-reconoce", "diego", "roberto",
	}
	rec.SetSamples(samples, cats)

	// Procesa cada archivo en el directorio
	files, err := os.ReadDir(imagesDir)
	if err != nil {
		log.Fatalf("Error reading directory: %v", err)
	}

	for _, file := range files {
		if file.IsDir() {
			// Si el archivo es un directorio, se puede omitir o manejar según sea necesario
			continue
		}

		// Construye la ruta completa del archivo
		filePath := filepath.Join(imagesDir, file.Name())

		// Reconoce la cara en la imagen
		newFace, err := rec.RecognizeSingleFile(filePath)
		if err != nil {
			log.Printf("Error recognizing image %s: %v", file.Name(), err)
			continue
		}
		if newFace == nil {
			//log.Printf("Face Not recog", file.Name())
			fmt.Println("Face Not Recog")
			continue
		}

		// Clasifica la cara reconocida
		catID := rec.Classify(newFace.Descriptor)
		if catID < 0 {
			log.Printf("Error classifying image %s", file.Name())
			continue
		}

		// Reporta el resultado
		//fmt.Printf("Image: %s, Category ID: %d\n", file.Name(), catID)
		fmt.Println(labels[catID])
	}
}
