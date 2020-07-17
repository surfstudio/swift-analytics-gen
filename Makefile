TOOL_NAME =AnalyticsGen
BUILD_PATH =.build/release/$(TOOL_NAME)

test:
	swift test

executable: test
	git add Sources/AnalyticsGen/Resources/LibConstants.swift
	git add Docs/integration_guide.md
	git add AnalyticsGen.podspec
	git commit -m "bumb version $(V)"
	git push origin
	pod trunk push --allow-warnings
	git tag $(V)
	git push origin $(V)