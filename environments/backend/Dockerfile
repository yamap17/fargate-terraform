FROM hashicorp/terraform:1.3.6
WORKDIR /terraform/environments/backend

ADD ./environments/backend /terraform/environments/backend
ADD ./modules /terraform/modules
RUN terraform get

ENTRYPOINT [""]
CMD ["/bin/sh"]