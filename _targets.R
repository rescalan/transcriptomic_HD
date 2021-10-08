library(targets)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
# summ <- function(dataset) {
#   summarize(dataset, mean_x = mean(x))
# }

# Set target-specific options such as packages.
tar_option_set(packages = "dplyr")

# functions ---------------------------------------------------------------

run_dct <- function(a, b){
  
}

run_alignment_gene_quantification <- function(a, b){
  
}

# plan --------------------------------------------------------------------



# End this file with a list of target objects.
list(
  tar_target(rna_seq_reads,
             iris),
  tar_target(mouse_ref_genome,
             iris
             ),
  
  tar_target(mouse_disease_signature, 
             run_alignment_gene_quantification(rna_seq_reads, mouse_ref_genome)
             ),
  tar_target(mouse_drug_signature, 
             run_alignment_gene_quantification(rna_seq_reads, mouse_ref_genome)),
  tar_target(human_disease_signature,
             iris), # scrape data from sql
  tar_target(biological_genesets_ql,
             iris),
  tar_target(reversal_mouse,
             run_dct(mouse_disease_signature, mouse_drug_signature)
             ),
  tar_target(reversal_human,
             run_dct(human_disease_signature, mouse_drug_signature))
  
   # Call your custom functions as needed.
)

# TODO we eventually created our own workflow
# Explain building in a workflow step by step
