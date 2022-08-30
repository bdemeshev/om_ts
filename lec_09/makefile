file_name = om_ts_09

$(file_name).pdf: $(file_name).tex chapters/*.tex figures/
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# remove file indicator of handout
	-rm .produce_handout


	# create pdf
	# will automatically run pdflatex/biber if necessary
	# latexmk -xelatex $(file_name).tex
	
	arara -v $(file_name).tex

	# clean auxillary files
	# latexmk -c $(file_name).tex

	@echo
	@echo
	@echo ---------------------------------------------
	@echo 'To make pngs use "make png"'
	@echo ---------------------------------------------
	@echo 'To compile handout version use "make handout"'
	@echo ---------------------------------------------
	@echo 'To clean non source files use "make clean"'
	@echo ---------------------------------------------


png:
	mkdir -p slides
	pdftocairo $(file_name).pdf slides/$(file_name) -png -r 300 -transp 

handout:
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create file indicator of handout and copy the original tex
	# we copy original file to not override pdf
	touch .produce_handout
	cp $(file_name).tex $(file_name)_handout.tex


	# create pdf
	# will automatically run pdflatex/biber if necessary
	# latexmk -xelatex $(file_name)_handout.tex


	arara -v $(file_name)_handout.tex

	# remove file indicator of handout 
	-rm .produce_handout

	# clean auxillary files
	latexmk -c $(file_name)_handout.tex

	# remove auxillary tex file
	-rm $(file_name)_handout.tex


clean:
	latexmk -c $(file_name).tex
	# latexmk -c $(file_name)_handout.tex
	-rm *.nav
	-rm *.snm
	-rm *.xdv
	-rm *.blg
	-rm *.bbl
	-rm *.log
	-rm *.aux

