#!/usr/bin/env bash
# Quick test to verify awesome-enhanced loads correctly

echo "Testing awesome-enhanced..."
echo ""

# Test 1: Check if script finds lib-enhanced
echo "Test 1: Checking if lib-enhanced loads..."
if ./awesome-enhanced --version 2>/dev/null | grep -q "0.6.0"; then
    echo "✓ Version check passed"
else
    echo "✗ Version check failed"
fi

# Test 2: Check if doctor command works
echo ""
echo "Test 2: Checking doctor command..."
if ./awesome-enhanced doctor 2>&1 | grep -q "Health Check"; then
    echo "✓ Doctor command works"
else
    echo "✗ Doctor command failed"
fi

# Test 3: Check if enhanced functions are available
echo ""
echo "Test 3: Checking enhanced help..."
if ./awesome-enhanced --help 2>&1 | grep -q "NEW COMMANDS"; then
    echo "✓ Enhanced help available"
else
    echo "✗ Enhanced help not found"
fi

echo ""
echo "Testing complete!"
