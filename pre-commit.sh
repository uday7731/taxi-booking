#!/bin/bash

# Run JaCoCo to check code coverage
mvn clean test jacoco:report

# Check coverage percentage
COVERAGE_THRESHOLD=80  # Set your desired coverage threshold
CURRENT_COVERAGE=$(mvn -q -Dexec.executable="echo" -Dexec.args="${project.version}" --non-recursive exec:exec)

if (( $(echo "$CURRENT_COVERAGE < $COVERAGE_THRESHOLD" | bc -l) )); then
    echo "Error: Code coverage below threshold. Current coverage: $CURRENT_COVERAGE%"
    exit 1  # Exit with error to prevent commit
fi

