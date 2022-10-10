FROM dart:stable as base

WORKDIR /usr/app

# Resolve local dependencies
COPY ./packages/shared ./packages/shared

COPY ./services/server ./services/server

WORKDIR /usr/app/services/server

RUN dart pub get
    
FROM base as between

# Build a minimal serving image
RUN dart compile exe ./bin/server.dart -o ./bin/server

FROM scratch as prod

COPY --from=between /runtime/ /
COPY --from=between /usr/app/services/server/bin/server /usr/app/bin/

ENV SHELF_HOTRELOAD=false

EXPOSE 8080

CMD [ "/usr/app/bin/server" ]