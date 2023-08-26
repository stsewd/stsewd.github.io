Run pandoc from docker:

```bash
# If the container is not created:
docker run --name pandoc-latex --volume "`pwd`:/data":z --entrypoint sh -it pandoc/ubuntu-latex

# If the container is already created:
docker start pandoc-latex
docker exec -it pandoc-latex bash
```

Convert to PDF with some custom fonts and styles:

```bash
apt update
apt install -y texlive-fonts-extra
apt install -y texlive-full
pandoc --pdf-engine=xelatex --standalone --from commonmark_x -V 'mainfont:NotoSansMono-Regular' -V pagestyle:empty cv.md -o cv.pdf
pandoc --pdf-engine=xelatex --standalone --from commonmark_x -V 'mainfont:NotoSansMono-Regular' -V pagestyle:empty cv.es.md -o cv.es.pdf
```
