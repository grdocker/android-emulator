FROM grascm/android-tools-base:latest

RUN apt update && \
    apt install -y socat && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ARG API_VERSION=30
ENV PACKAGE="system-images;android-$API_VERSION;google_apis;x86"
RUN sdkmanager --install "$PACKAGE"

ARG DEVICE=pixel_xl
RUN avdmanager create avd -k "$PACKAGE" -n test_avd -d "$DEVICE"

EXPOSE 5554 5555

COPY run_emulator /usr/bin

CMD run_emulator
