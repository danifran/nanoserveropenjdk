#docker build . -t danifran/nanoserverOpenJDK:14.393-9.0.4
#Openjdk 9 unpacking
FROM danifran/nanoserver7zip as installerhost
ADD https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz c:/Temp/Java.tar.gz
RUN powershell -Command\
    cd temp; \
    7z e java.tar.gz; \
    7z x  Java.tar;

FROM microsoft/nanoserver as targetImage
LABEL Maintainer="Daniele Francioni"
LABEL OsVersion="14.393"  OpenJDKVersion="9.0.4"
COPY --from=installerhost ["c:/temp/jdk-9.0.4", "c:/Program files/Java/jdk-9.0.4"]
RUN SetX /M PATH "c:\Program files\Java\jdk-9.0.4\bin;%PATH%" &\
    SetX /M JAVA_HOME "c:\Program files\Java\jdk-9.0.4";

CMD powershell

