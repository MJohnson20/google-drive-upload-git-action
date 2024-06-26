FROM golang:1.21.9-windowsservercore-ltsc2022 as BUILD

WORKDIR /src/
COPY . /src/

RUN go mod tidy
ENV CGO_ENABLED=0
RUN go build -o /bin/app .

FROM mcr.microsoft.com/windows/servercore:ltsc2022
COPY --from=BUILD /bin/app /bin/app
ENTRYPOINT [ "/bin/app" ]
