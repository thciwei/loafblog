FROM nginx
ADD ./dist /usr/share/nginx/html/
RUN rm /etc/nginx/conf.d/default.conf
ADD default.conf /etc/nginx/conf.d/
#RUN rm /etc/nginx/nginx.conf
#ADD ./nginx.conf  /etc/nginx/
CMD ["nginx", "-g", "daemon off;"]