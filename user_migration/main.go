package main

import (
	"context"
	"log"
	"os"

	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
)

func handle(err error) {
	if err != nil {
		log.Fatalln(err)
	}
}

var srcUser = os.Getenv("SRC_USER")
var dstuser = os.Getenv("DST_USER")

func main() {

	// Use a service account
	ctx := context.Background()
	sa := option.WithCredentialsFile(os.Getenv("CRED_FILE"))
	app, err := firebase.NewApp(ctx, nil, sa)
	handle(err)
	client, err := app.Firestore(ctx)
	handle(err)
	defer client.Close()
	snapshot, err := client.Collection("users").Doc(srcUser).Get(ctx)
	handle(err)
	data := snapshot.Data()
	log.Printf("%+v", data)
	res, err := client.Collection("users").Doc(dstuser).Set(ctx, data)
	handle(err)
	log.Printf("%+v", res)
}
