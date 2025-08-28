## Multi-target Dockerfile
## Builder stage: contains Flutter and all native build dependencies required
FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV FLUTTER_ROOT=/flutter
ENV PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/flutter/bin:/flutter/bin/cache/dart-sdk/bin

WORKDIR /app

# Install system packages needed for Linux desktop builds and Android tooling
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates curl unzip wget git gnupg2 openjdk-11-jdk \
		build-essential clang cmake ninja-build pkg-config \
		libgtk-3-dev libwebkit2gtk-4.0-dev libsecret-1-dev libgdk-pixbuf2.0-dev xdg-utils \
		libasound2-dev libpulse-dev libglu1-mesa-dev \
	&& rm -rf /var/lib/apt/lists/*

# Install git and clone Flutter at v3.35.2 to ensure Dart SDK matches pubspec
RUN git --version || true
RUN cd / && git clone --depth 1 --branch 3.35.2 https://github.com/flutter/flutter.git /flutter && /flutter/bin/flutter --version || true

# Install Android command-line tools (cmdline-tools)
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
		cd /tmp && \
		wget -q -O cmdline.zip "https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip" && \
		unzip -q cmdline.zip && \
		mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
		mv cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/latest/ && \
		rm -rf /tmp/cmdline.zip /tmp/cmdline-tools

# Ensure sdkmanager is available and install core Android SDK components
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses || true && \
		${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# Cache pub dependencies by copying only pubspec files first
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the source
COPY . ./

# Optional: pre-cache web artifacts (can speed up first build)
RUN flutter precache --web || true

# Build targets (web, android apk, linux)
# If any target fails you can comment out that run or adjust for CI needs
RUN flutter build web --release || true
RUN flutter build apk --release || true
RUN flutter build linux --release || true

# Create a simple artifacts directory that collects outputs
RUN mkdir -p /artifacts/web /artifacts/android /artifacts/linux && \
		cp -r build/web/* /artifacts/web/ || true && \
		cp -r build/app/outputs/flutter-apk/app-release.apk /artifacts/android/ 2>/dev/null || true && \
		cp -r build/linux/x64/release/bundle /artifacts/linux/ 2>/dev/null || true

## Runtime image that serves the web output via nginx and exposes artifacts
FROM nginx:alpine AS runtime

RUN rm -rf /usr/share/nginx/html/*

# Copy web files from builder
COPY --from=builder /artifacts/web /usr/share/nginx/html

# Copy custom nginx config (listens on 3000)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Also copy other artifacts for easy retrieval from the image
COPY --from=builder /artifacts /artifacts

EXPOSE 3000

# Default: serve web. The built artifacts (APK, linux bundle) are available in /artifacts
CMD ["nginx", "-g", "daemon off;"]
