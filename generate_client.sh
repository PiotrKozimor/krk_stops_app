#!/bin/bash
protoc -I ../krkstops/pb/ krk-stops.proto --dart_out=grpc:lib/grpc