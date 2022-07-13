# Generate 
```bash
openapi-generator-cli generate \
  --input-spec ../../infrastructure/sam/api.yaml \
  --additional-properties library=apache-httpclient,groupId=edu.uva.cs,artifactId=moraldistressapi \
  --generator-name java
```
