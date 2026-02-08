FROM amazoncorretto:17
WORKDIR /app/
RUN yum install -y curl jq wget unzip && yum clean all
RUN wget -q $(curl -s https://api.github.com/repos/tabulapdf/tabula/releases/latest | jq -r '[.assets[] | select(.name | contains("zip"))][0] | .browser_download_url') \
    && unzip -q *.zip \
    && rm -f *.zip
EXPOSE 8080
CMD ["java", "--add-opens", "java.base/java.util.zip=ALL-UNNAMED", "--add-exports", "java.desktop/sun.java2d=ALL-UNNAMED", "-Dfile.encoding=utf-8", "-Xms256M", "-Xmx1024M", "-Dwarbler.port=8080", "-Dtabula.openBrowser=false", "-jar", "/app/tabula/tabula.jar"]
