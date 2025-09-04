#!/bin/bash

# Disable AWS services for local development
export AWS_ENABLED="false"

# Subscription price ID mappings
# Override the application properties with environment variables if needed
export SUBSCRIPTION_PREMIUM_PRICE_IDS="price_1RmqWxELoozGI1YxQql5rsvN"
export SUBSCRIPTION_STANDARD_PRICE_IDS="price_standard"

# Run the application with dev profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
