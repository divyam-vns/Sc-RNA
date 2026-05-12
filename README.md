# Running Docker Locally for NBIS scRNA-seq Workshop

This guide helps you run the NBIS scRNA-seq workshop container **locally** using Docker.

## Prerequisites

- [Install Docker](https://docs.docker.com/get-docker/)
- Ensure Docker is running correctly:  
  ```bash
  docker --version
  ```

## 1. Pull the Docker Image

Run the following command to download the container image:

```bash
docker pull quay.io/nbisweden/workshop-scRNAseq:2023.10
```

## 2. Set Up a Project Directory

Create a local directory that will be accessible inside the container:

```bash
mkdir -p ~/scrnaseq_workshop
```

## 3. Start the Container

Run this command to launch the container:

```bash
docker run -it --rm \
  -p 8888:8888 \
  -v ~/scrnaseq_workshop:/home/rstudio/project \
  quay.io/nbisweden/workshop-scRNAseq:2023.10
```

- `-it` → interactive mode
- `--rm` → auto-remove container on exit
- `-p 8888:8888` → maps Jupyter/RStudio ports
- `-v ~/scrnaseq_workshop:/home/rstudio/project` → mounts your local directory into the container

## 4. Access RStudio in Your Browser

After running the above command, you’ll see a message like:

```
Starting RStudio server...

RStudio Server is running at: http://localhost:8888

Username: rstudio
Password: rstudio
```

Open a browser and go to [http://localhost:8888](http://localhost:8888), then log in using:

- **Username:** `rstudio`
- **Password:** `rstudio`

## 5. Saving Work

Any work saved inside `/home/rstudio/project` in RStudio will be saved to your local `~/scrnaseq_workshop` directory.

---

## Stopping

To stop the container, just press `Ctrl+C` in the terminal running Docker.

## Cleaning Up

Docker will remove the container automatically because we used `--rm`.

## Troubleshooting

- **Port already in use?** Try another port like `-p 8787:8888`
- **Permission denied on mount?** Use absolute paths or try:
  ```bash
  sudo chmod -R a+rwx ~/scrnaseq_workshop
  ```
