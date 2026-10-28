# Eclipse IDE & Apache Tomcat 11 Setup Guide

This project is configured as a **Jakarta EE 10/11 Dynamic Web Project** and **Maven Project**, ready to import into **Eclipse** and run on **Apache Tomcat 11.0**.

---

## 1. Project Configuration Summary

* **Project Descriptor**: [`.project`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/.project) configured with Java, Maven (`m2e`), and WTP Web Facet natures.
* **Build Path**: [`.classpath`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/.classpath) configured for Java 11/17/21 and Maven dependencies (`/WEB-INF/lib`).
* **Web Facet**: [`.settings/org.eclipse.wst.common.project.facet.core.xml`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/.settings/org.eclipse.wst.common.project.facet.core.xml) set to `jst.web 6.0` (Jakarta Servlet 6.1 for Tomcat 11).
* **Deployment Assembly**: [`.settings/org.eclipse.wst.common.component`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/.settings/org.eclipse.wst.common.component) routes `src/main/webapp` to `/` with context-root `ecommerce-catalog`.
* **Deployment Descriptor**: [`web.xml`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/src/main/webapp/WEB-INF/web.xml) using Jakarta EE schema (`version="6.0"`).
* **Interactive UI**: [`index.jsp`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/src/main/webapp/index.jsp) displaying Laptops, T-Shirts, and interactive Flash Sale controls.
* **Servlets**:
  * [`ProductCatalogServlet.java`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/src/main/java/com/ecommerce/servlet/ProductCatalogServlet.java) (`/products`)
  * [`FlashSaleServlet.java`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/src/main/java/com/ecommerce/servlet/FlashSaleServlet.java) (`/flash-sale`)
* **Deployable Artifact**: [`target/ecommerce-catalog.war`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/target/ecommerce-catalog.war).

---

## 2. Importing into Eclipse IDE

### Method A: Import as Existing Maven Project (Recommended)
1. Open **Eclipse IDE**.
2. Select **File** > **Import...**
3. Expand **Maven** > select **Existing Maven Projects** > click **Next**.
4. In **Root Directory**, click **Browse...** and select:
   `c:\Users\Prat\OneDrive\Documents\Project\AIP Pro`
5. Ensure `pom.xml` (`com.ecommerce:ecommerce-catalog`) is checked.
6. Click **Finish**. Eclipse will build the workspace and link the Maven libraries.

---

## 3. Configuring Apache Tomcat 11 in Eclipse

1. In Eclipse, open the **Servers** view (if not visible: **Window** > **Show View** > **Other...** > **Server** > **Servers**).
2. Click the link: *"No servers are available. Click this link to create a new server..."* (or right-click in Servers view > **New** > **Server**).
3. Expand **Apache** and select:
   * **Tomcat v11.0 Server**
4. Click **Next**.
5. In **Tomcat installation directory**, browse to:
   `C:\Program Files\Apache Software Foundation\Tomcat 11.0`
6. Select your **JRE / JDK** (JDK 25, 21, or 17).
7. Click **Finish**.

---

## 4. Running the Web Application on Tomcat 11

1. In the **Project Explorer** in Eclipse, right-click `ecommerce-catalog`.
2. Select **Run As** > **Run on Server**.
3. Choose the **Tomcat v11.0 Server** and click **Finish**.
4. Tomcat 11 will start and deploy the application.
5. Access the application in your browser:
   * **Catalog Dashboard**: `http://localhost:8080/ecommerce-catalog/`
   * **Products Endpoint**: `http://localhost:8080/ecommerce-catalog/products`
   * **Flash Sale Action**: Test the interactive discount form directly on the web page!

---

## 5. Alternative: Running Standalone via Tomcat 11 `webapps`

You can also run the packaged WAR file directly without Eclipse:
1. Copy [`target/ecommerce-catalog.war`](file:///c:/Users/Prat/OneDrive/Documents/Project/AIP%20Pro/target/ecommerce-catalog.war) to:
   `C:\Program Files\Apache Software Foundation\Tomcat 11.0\webapps\`
2. Start the Tomcat 11 service.
3. Open `http://localhost:8080/ecommerce-catalog/` in your browser.

