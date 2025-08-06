# Testing

## Integration Testing - e2e

- We can define e2e test for every flavor.
- All integration tests must be organized in the folder `/integration_test/{flavor}/`

For run test

```bash
 fvm flutter test integration_test/{flavor}/{test_file}.dart --flavor {flavor} -d {deviceId}
```