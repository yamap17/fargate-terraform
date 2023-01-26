FROM hashicorp/terraform:1.3.6
WORKDIR /terraform/environments/production

ADD ./environments/production /terraform/environments/production
ADD ./modules /terraform/modules
RUN terraform get

ENTRYPOINT [""]
CMD ["/bin/sh"]