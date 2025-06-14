
# 🔬 Generalized Single-Cell RNA-seq Analysis Tutorial (Seurat-based)

This tutorial provides a generalized workflow for analyzing single-cell RNA sequencing (scRNA-seq) data using the [Seurat](https://satijalab.org/seurat/) package in R. It is adapted from the official PBMC3k Seurat tutorial and can be reused for other scRNA-seq datasets in 10x Genomics format.

---

## 📦 Step 1: Installation and Setup

```R
# Install Seurat from CRAN
install.packages("Seurat")

# Load libraries
library(Seurat)
library(dplyr)
library(ggplot2)
```

---

## 📁 Step 2: Load the Data

```R
# Replace with your data directory (must contain matrix.mtx, features.tsv, barcodes.tsv)
data_dir <- "your_data_directory/"
sc_data <- Read10X(data.dir = data_dir)

# Create a Seurat object
seurat_obj <- CreateSeuratObject(counts = sc_data, project = "MyProject", min.cells = 3, min.features = 200)
```

---

## 🧼 Step 3: Quality Control and Filtering

```R
seurat_obj[["percent.mt"]] <- PercentageFeatureSet(seurat_obj, pattern = "^MT-")

# Visualize QC metrics
VlnPlot(seurat_obj, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)

# Filter cells
seurat_obj <- subset(seurat_obj, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
```

---

## 🧪 Step 4: Normalize the Data

```R
seurat_obj <- NormalizeData(seurat_obj, normalization.method = "LogNormalize", scale.factor = 10000)
```

---

## 🧬 Step 5: Identify Highly Variable Features

```R
seurat_obj <- FindVariableFeatures(seurat_obj, selection.method = "vst", nfeatures = 2000)

# Visualize top 10 features
top10 <- head(VariableFeatures(seurat_obj), 10)
VariableFeaturePlot(seurat_obj) + LabelPoints(points = top10, repel = TRUE)
```

---

## ⚖️ Step 6: Scale the Data

```R
all.genes <- rownames(seurat_obj)
seurat_obj <- ScaleData(seurat_obj, features = all.genes)
```

---

## 📉 Step 7: Principal Component Analysis (PCA)

```R
seurat_obj <- RunPCA(seurat_obj, features = VariableFeatures(object = seurat_obj))

# Visualize PCA
ElbowPlot(seurat_obj)
```

---

## 🔍 Step 8: Determine Dimensionality

- Use ElbowPlot or JackStrawPlot to determine the optimal number of principal components (PCs) to retain.

---

## 🔗 Step 9: Clustering the Cells

```R
seurat_obj <- FindNeighbors(seurat_obj, dims = 1:10)
seurat_obj <- FindClusters(seurat_obj, resolution = 0.5)

# Check cluster assignments
head(Idents(seurat_obj), 10)
```

---

## 🌀 Step 10: Run UMAP for Visualization

```R
seurat_obj <- RunUMAP(seurat_obj, dims = 1:10)
DimPlot(seurat_obj, reduction = "umap")
```

---

## 🧾 Step 11: Find Cluster-Specific Marker Genes

```R
cluster_markers <- FindAllMarkers(seurat_obj, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)

# View top markers
head(cluster_markers)
```

---

## 📊 Step 12: Visualize Marker Expression

```R
# Change gene names to genes relevant to your dataset
FeaturePlot(seurat_obj, features = c("GeneA", "GeneB"))
VlnPlot(seurat_obj, features = c("GeneA", "GeneB"))
```

---

## 💾 Step 13: Save and Export Results

```R
saveRDS(seurat_obj, file = "seurat_processed.rds")
write.csv(cluster_markers, "cluster_markers.csv")
```

---

## ✅ Summary of Workflow

- **Load and QC the data**
- **Normalize and scale**
- **Dimensionality reduction with PCA**
- **Cell clustering and UMAP**
- **Marker gene identification and visualization**
- **Exporting results**

---

## 📚 References

- [Seurat PBMC3k Tutorial](https://satijalab.org/seurat/articles/pbmc3k_tutorial)
- [Seurat GitHub](https://github.com/satijalab/seurat)

---

## 🧠 Tip

You can modify filtering thresholds and number of PCs depending on your dataset’s characteristics.
