#!/bin/bash
# Test script to verify PHP environment variables are applied correctly

echo "🔧 Building Docker image..."
docker build -t php-docker-nginx-test .

echo ""
echo "🧪 Testing with custom environment variables..."
echo "   - PHP_MEMORY_LIMIT=512M"
echo "   - PHP_UPLOAD_MAX_FILESIZE=250M"
echo "   - PHP_POST_MAX_SIZE=250M"
echo ""

# Run container with environment variables
CONTAINER_ID=$(docker run -d \
  -p 8080:80 \
  -e PHP_MEMORY_LIMIT=512M \
  -e PHP_UPLOAD_MAX_FILESIZE=250M \
  -e PHP_POST_MAX_SIZE=250M \
  -e PHP_MAX_EXECUTION_TIME=300 \
  -e PHP_MAX_INPUT_TIME=120 \
  php-docker-nginx-test)

echo "✅ Container started: $CONTAINER_ID"
echo ""

# Wait for container to be ready
echo "⏳ Waiting for container to be ready..."
sleep 5

# Check logs to see if configuration was applied
echo ""
echo "📋 Container startup logs:"
docker logs $CONTAINER_ID 2>&1 | grep -A 10 "Applied PHP configuration"

echo ""
echo "🔍 Verifying PHP configuration inside container..."
docker exec $CONTAINER_ID php -i | grep -E "memory_limit|upload_max_filesize|post_max_size|max_execution_time|max_input_time" | grep -v ";" | head -5

echo ""
echo "🌐 Access the configuration checker at:"
echo "   http://localhost:8080/config-check.php"
echo ""
echo "🛑 To stop the container:"
echo "   docker stop $CONTAINER_ID"
echo "   docker rm $CONTAINER_ID"
