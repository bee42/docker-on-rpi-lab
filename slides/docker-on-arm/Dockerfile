FROM rossbachp/presentation
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ADD images /opt/presentation/images
ADD slides.md /opt/presentation/lib/md/slides.md
ADD LICENSE /opt/presentation/lib/md/LICENSE

ADD LICENSE /etc/LICENSE

RUN echo "rossbachp docker orchestration" >/etc/provisioned && date >>/etc/provisioned && echo >>/etc/provisioned && echo " Copyright by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned
