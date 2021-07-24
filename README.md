# docker-bfg-repo-cleaner
Simple image for btf command line tool of project: https://github.com/rtyley/bfg-repo-cleaner

You could use the this image like a local installed btf version by using the following command:
```
docker run -v `pwd`:/workdir --rm docker2snap/bfg-repo-cleaner
```

This will mount your current directory to the image, so that the btf tool inside of docker could do the cleanup.
Of course you could append any needed parameter after the docker run command.

Version tagging will be in sync to the builded versions of the bfg-repo-cleaner.
