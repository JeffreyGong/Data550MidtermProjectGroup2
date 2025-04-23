report.html: Outputs/three_pt_regression_plot.png Ramya_Code/nba_generate_report.Rmd report.Rmd render_report.R
	Rscript render_report.R
	
Outputs/three_pt_regression_plot.png: Joseph_Code/three_pt_reg.R Clean_Data/data_${WHICH_CONFIG}.rds
	Rscript Joseph_Code/three_pt_reg.R
	
Clean_Data/data_${WHICH_CONFIG}.rds: Data/nba_2025-03-07 Jeffrey_Code/filter_data.R 
	Rscript Jeffrey_Code/filter_data.R
	
clean:
	rm Clean_Data/*.rds && \
	rm Outputs/*.rds && \
	rm Outputs/*.png
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"