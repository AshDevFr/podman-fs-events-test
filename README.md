# Podman + Podman Compose test 

We have found an issue when migrating from Docker to Podman that we have not been able to fix yet.

When we mount files to the container on our local setup, neither `Rails` nor `Gulp.js` are picking the changes to the files.

When we look inside the container, the files are correctly changed.

## This setup

This project was created using `Vite.js` to illustrate the issue and try to come up with a solution.

```bash
npm create vite@latest web -- --template react-swc
````


## Running the tests

Run one of the following commands, then open [http://localhost:5173/](http://localhost:5173/) in your browser to see the app.

In `src/App.jsx`, make a change to the code. Example `count is {count}` => `The count of clicks is {count}`.

`Vite` should pick up the change and update the page.

### Using Docker

```bash
docker build -t vite-app .
docker run --rm \
  -p 5173:5173 \
  -v $(pwd)/web/public:/app/public \
  -v $(pwd)/web/src:/app/src \
  -v $(pwd)/web/eslint.config.js:/app/eslint.config.js \
  -v $(pwd)/web/index.html:/app/index.html \
  -v $(pwd)/web/package.json:/app/package.json \
  -v $(pwd)/web/package-lock.json:/app/package-lock.json \
  -v $(pwd)/web/vite.config.js:/app/vite.config.js \
  vite-app \
    npm run dev
```

[Docker run video](./assets/docker-run.mp4)

### Using Podman

```bash
podman build -t vite-app .
podman run --rm --name vite-app \
  -p 5173:5173 \
  -v $(pwd)/web/public:/app/public \
  -v $(pwd)/web/src:/app/src \
  -v $(pwd)/web/eslint.config.js:/app/eslint.config.js \
  -v $(pwd)/web/index.html:/app/index.html \
  -v $(pwd)/web/package.json:/app/package.json \
  -v $(pwd)/web/package-lock.json:/app/package-lock.json \
  -v $(pwd)/web/vite.config.js:/app/vite.config.js \
  vite-app \
    npm run dev
```

Using `exec` we can confirm that the changes are applied to the file inside the container.

```bash
podman exec vite-app sh -c "cat /app/src/App.jsx" | grep count
```

[Podman run video](./assets/podman-run.mp4)

### Using Docker Compose

```bash
docker compose build
docker compose up
```

[Docker compose video](./assets/docker-compose.mp4)

### Using Podman Compose

```bash
podman compose build
podman compose up
```

Using `exec` we can confirm that the changes are applied to the file inside the container.

```bash
podman compose exec frontend sh -c "cat /app/src/App.jsx" | grep count
```

[Podman compose video](./assets/podman-compose.mp4)



