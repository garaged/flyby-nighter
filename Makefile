SHELL := /bin/bash

.PHONY: validate build test mobile-build run-macos run-macos-reset run-macos-muted package-first-tester clean-first-tester

validate:
	bash scripts/first-tester/validate.sh

build:
	swift build

test:
	swift test

mobile-build:
	xcodebuild \
		-project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj \
		-scheme FlybyNighterMobile \
		-sdk iphonesimulator \
		-destination 'generic/platform=iOS Simulator' \
		CODE_SIGNING_ALLOWED=NO \
		build

run-macos:
	swift run FlybyNighterApp

run-macos-reset:
	swift run FlybyNighterApp -- --reset-high-scores

run-macos-muted:
	swift run FlybyNighterApp -- --mute-audio

package-first-tester:
	bash scripts/first-tester/package-macos.sh

clean-first-tester:
	rm -rf .build/first-tester
