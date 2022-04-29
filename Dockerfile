# L'image de base sera une image nginx:1.21.1
FROM nginx:1.21.1

# Ne pas oublier de mentionner le maintainer de l'image

LABEL maintainer='REDDAD HARDALA'

# MAJ l'image, puis installer curl et git
RUN apt-get update&& \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get install -y git


# Supprimer le contenu du répertoire /usr/share/nginx/html/
RUN rm -Rf /usr/share/nginx/html/*


# Téléchargement de l'application avec un git clone et déposer au bon endroit
RUN git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html/

# Rajouter le fichier de conf donné de nginx  dans /etc/nginx/conf.d/

COPY nginx.conf /etc/nginx/conf.d/default.conf


CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'