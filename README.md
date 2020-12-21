Run pandoc from docker:

```bash
docker run --name pandoc-latex --volume "`pwd`:/data":z --entrypoint sh -it pandoc/ubuntu-latex
```

Convert to PDF with some custom fonts and styles:

```bash
apt install texlive-fonts-extra
apt install texlive-full
pandoc --pdf-engine=xelatex --standalone --from commonmark_x -V 'mainfont:NotoSansMono-Regular' -V pagestyle:empty cv.md -o cv.pdf
pandoc --pdf-engine=xelatex --standalone --from commonmark_x -V 'mainfont:NotoSansMono-Regular' -V pagestyle:empty cv.es.md -o cv.es.pdf
```
