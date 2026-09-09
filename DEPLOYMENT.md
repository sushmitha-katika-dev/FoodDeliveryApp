# 🚀 FoodZone — Deployment & Hosting Guide

This guide walks you through deploying **FoodZone** to the cloud using Docker, Render, Railway, or standard Tomcat servers.

---

## 🛠️ Table of Contents
1. [Prerequisites](#-prerequisites)
2. [Option 1: Deploy with Docker & Docker Compose (Local & Cloud VPS)](#option-1-deploy-with-docker--docker-compose)
3. [Option 2: Deploy to Render (Free Cloud Web Service)](#option-2-deploy-to-render-free-cloud-web-service)
4. [Option 3: Deploy to Railway](#option-3-deploy-to-railway)
5. [Option 4: Deploy WAR to Standalone Apache Tomcat](#option-4-deploy-war-to-standalone-apache-tomcat)
6. [Automated CI/CD with GitHub Actions](#-automated-cicd-with-github-actions)

---

## 📋 Prerequisites
- **Java JDK 17+**
- **Apache Maven 3.8+**
- **MySQL Server 8.0+** (or Docker)
- Git installed and configured

---

## Option 1: Deploy with Docker & Docker Compose

The easiest, 1-command deployment for local testing or any cloud VPS (Ubuntu/Debian on AWS EC2, DigitalOcean, Hetzner, Linode):

```bash
# 1. Clone your repository
git clone https://github.com/sushmitha-katika-dev/FoodDeliveryApp.git
cd FoodDeliveryApp

# 2. Start MySQL and FoodZone containers
docker-compose up -d --build
```

- **App URL**: `http://localhost:8080` (or `http://<your-server-ip>:8080`)
- **MySQL Database**: Running on port `3306` with database `food` pre-loaded from `FoodApp/database/food_delivery.sql`.

---

## Option 2: Deploy to Render (Free Cloud Web Service)

Render allows you to deploy containerized web services directly from your GitHub repository.

1. **Sign in to Render**: Go to [render.com](https://render.com) and connect your GitHub account.
2. **Create MySQL Database**:
   - Click **New** ➔ **PostgreSQL** or deploy a free MySQL instance via **Aiven.io** or **PlanetScale**.
   - Import the database schema from [`FoodApp/database/food_delivery.sql`](FoodApp/database/food_delivery.sql).
3. **Create Web Service**:
   - Click **New** ➔ **Web Service**.
   - Select your repository: `sushmitha-katika-dev/FoodDeliveryApp`.
   - **Environment**: `Docker`.
   - **Branch**: `main`.
   - **Plan**: Free.
4. **Configure Environment Variables**:
   - `DB_HOST`: Your remote MySQL host
   - `DB_PORT`: `3306`
   - `DB_NAME`: `food`
   - `DB_USER`: Your MySQL username
   - `DB_PASSWORD`: Your MySQL password
5. Click **Create Web Service** — Render will automatically build the `Dockerfile` and give you a live `https://foodzone-xxxx.onrender.com` URL!

---

## Option 3: Deploy to Railway

1. Go to [railway.app](https://railway.app) and create an account.
2. Click **New Project** ➔ **Provision MySQL**.
   - Connect via MySQL CLI or TablePlus and run `food_delivery.sql`.
3. Click **New** ➔ **GitHub Repo** ➔ select `FoodDeliveryApp`.
4. Railway will automatically detect the `Dockerfile` and deploy the app.
5. In the settings tab, click **Generate Domain** to get your public HTTPS URL.

---

## Option 4: Deploy WAR to Standalone Apache Tomcat

If you are deploying to a traditional server with Tomcat 10.1 installed:

1. Build the production WAR bundle:
   ```powershell
   mvn clean package -DskipTests
   ```
2. Locate the generated WAR file:
   `FoodApp/target/FoodApp-1.0.0.war`
3. Rename the file to `ROOT.war` (to serve on root `/`) or `foodapp.war`.
4. Copy the WAR file to your Tomcat `webapps/` directory:
   ```bash
   cp FoodApp/target/FoodApp-1.0.0.war /opt/tomcat/webapps/ROOT.war
   ```
5. Restart Tomcat:
   ```bash
   systemctl restart tomcat
   ```

---

## 🤖 Automated CI/CD with GitHub Actions

Every time you run `git push origin main`, our `.github/workflows/ci.yml` pipeline automatically:
1. Sets up JDK 17.
2. Compiles all Jakarta EE servlets and JSPs with Maven.
3. Packages the `.war` distribution artifact.
4. Verifies there are zero compilation errors.

You can download the packaged WAR directly from the **Actions** tab on your GitHub repository!
