package main

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

// Handler is our lambda handler invoked by the `lambda.Start` function call
func Handler(ctx context.Context) error {
	log.Println("hello by go func")

	return nil
}

func main() {
	lambda.Start(Handler)
}
