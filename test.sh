#!/bin/bash

IMAGE="dukintegrator:1.7.0"

assert_command() {
    local expected="$1"
    shift
    local result=$(docker run --rm -v "$PWD:/app/host" "$@" "$IMAGE" sh -c 'FALLBACK=${XML_FILE:-${PDF_FILE:-D${ID}}}; XML_FILE=${XML_FILE:-$FALLBACK}; PDF_FILE=${PDF_FILE:-$FALLBACK}; echo "java -jar ./DUKIntegrator.jar -p D$ID $HOST/$XML_FILE.xml $HOST/dukintegrator.log 0 0 $HOST/$PDF_FILE.pdf"')
    
    if [ "$result" = "$expected" ]; then
        echo "✅ PASS: $*"
    else
        echo "❌ FAIL: $*"
        echo "Expected: $expected"
        echo "Got:      $result"
        exit 1
    fi
}

echo "Testing scenarios..."

assert_command "java -jar ./DUKIntegrator.jar -p D100 /app/host/D100.xml /app/host/dukintegrator.log 0 0 /app/host/D100.pdf" \
    -e ID=100

assert_command "java -jar ./DUKIntegrator.jar -p D100 /app/host/D100_1234_1232232.xml /app/host/dukintegrator.log 0 0 /app/host/d100_validation.pdf" \
    -e ID=100 -e XML_FILE=D100_1234_1232232 -e PDF_FILE=d100_validation

assert_command "java -jar ./DUKIntegrator.jar -p D100 /app/host/custom_input.xml /app/host/dukintegrator.log 0 0 /app/host/custom_input.pdf" \
    -e ID=100 -e XML_FILE=custom_input

assert_command "java -jar ./DUKIntegrator.jar -p D100 /app/host/custom_output.xml /app/host/dukintegrator.log 0 0 /app/host/custom_output.pdf" \
    -e ID=100 -e PDF_FILE=custom_output

echo "All tests passed!"