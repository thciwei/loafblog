FROM nginx
ADD ./dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
#RUN rm /etc/nginx/nginx.conf
#ADD ./nginx.conf /etc/nginx/
CMD ["nginx", "-g", "daemon off;"]

