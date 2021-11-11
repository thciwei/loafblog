FROM nginx
ADD ./dist /usr/share/nginx/html/
RUN rm /etc/nginx/conf.d/default.conf
ADD default.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]
