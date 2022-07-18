#!/usr/bin/env nextflow


nextflow.enable.dsl=2


process split_csv {
    publishDir '/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/NF_IQ//bin/publishDir/', pattern: '*.png'

    input:
        val(data_directory)

    output:
        path '*.csv', emit: csv_out

    script:
        """
        Rscript ${workflow.projectDir}/bin/custom_scripts/plot_amd_split_by_IQ.R -d '$data_directory'
        """
}

dir = "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/NF_IQ/csvData.csv"
