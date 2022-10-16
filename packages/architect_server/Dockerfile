FROM dart:stable as base

WORKDIR /usr/app

# Resolve local dependencies
COPY ./packages/architect ./packages/architect

COPY ./packages/architect_server ./packages/architect_server

WORKDIR /usr/app/packages/architect_server

RUN dart pub get
    
FROM base as between

# Build a minimal serving image
RUN dart compile exe ./bin/architect_server.dart -o ./bin/architect_server

FROM scratch as prod

COPY --from=between /runtime/ /
COPY --from=between /usr/app/packages/architect_server/bin/architect_server /usr/app/bin/

ENV SHELF_HOTRELOAD=false

EXPOSE 8080

CMD [ "/usr/app/bin/architect_server" ]