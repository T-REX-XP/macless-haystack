# Use the official Nginx image
FROM nginx

# Define arguments for GitHub repository and release tag
ARG GITHUB_REPO
ARG RELEASE_TAG
# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Install wget to download files
RUN apt-get update && apt-get install -y wget unzip

# Download the latest release zip file from GitHub
# Replace "username/repo" with your GitHub username and repository name
RUN wget https://github.com/${GITHUB_REPO}/releases/download/${RELEASE_TAG}/webapplication.zip -O /tmp/webapplication.zip

# Unzip the release file and copy static files to Nginx html directory
RUN unzip /tmp/webapplication.zip -d /tmp/
RUN mv /tmp/web/* /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
