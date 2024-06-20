#!/bin/bash

LOCATION="europe-central2"
MODEL_ID="gemini-1.0-pro-vision"
PROJECT_ID="streamingai-33a74"

ACCESS_TOKEN=$(gcloud auth print-access-token)

curl \
-X POST \
-H "Authorization: Bearer $ACCESS_TOKEN" \
-H "Content-Type: application/json" \
https://$LOCATION-aiplatform.googleapis.com/v1/projects/$PROJECT_ID/locations/$LOCATION/publishers/google/models/$MODEL_ID:predict -d \
'{
  "instances": [
    {
      "contents": {
        "role": "user",
        "parts": [
          {
            "fileData": {
              "mimeType": "image/png",
              "fileUri": "/Users/peter/Desktop/man.jpg"
            }
          },
          {
            "text": "Does a person on a photo is more smoking, drinking water, laughing or agitated? Answer choosing one of the options by name."
          }
        ]
      }
    }
  ],
  "safety_settings": [
    {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_LOW_AND_ABOVE"
    }
  ],
  "generation_config": {
    "temperature": 0.4,
    "topP": 1,
    "topK": 32,
    "maxOutputTokens": 2048
  }
}'
