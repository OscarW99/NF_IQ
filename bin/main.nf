#!/usr/bin/env nextflow


nextflow.enable.dsl=2


process split_csv {
    publishDir "${workflow.projectDir}/publishDir/", mode:'copy', pattern: '*.png'

    input:
        val(data_directory)

    output:
        path '*.csv', emit: csv_out
        path '*.png', emit: png_scatter

    script:
        """
        Rscript ${workflow.projectDir}/custom_scripts/plot_and_split_by_IQ.R -d '$data_directory'
        """
}

dir = "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/NF_IQ/csvData.csv"
split_csv_input = Channel.of(dir)

workflow {
    split_csv(split_csv_input)
}