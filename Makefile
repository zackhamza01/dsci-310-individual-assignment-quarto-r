# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22

all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \
	docs/qmd_example.html \
	docs/qmd_example.pdf \
	docs/index.html



# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/generate_figures.R
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
docs/qmd_example.html: results docs/qmd_example.qmd
	quarto render docs/qmd_example.qmd --to html

docs/qmd_example.pdf: results docs/qmd_example.qmd
	quarto render docs/qmd_example.qmd --to pdf

# create index.html
docs/index.html: results docs/qmd_example.qmd 
	cp docs/qmd_example.html docs/index.html

# clean
clean:
	rm -rf results
	rm -rf docs/qmd_example.html \
		docs/qmd_example.pdf \
		docs/qmd_example_files \
		docs/index.html
