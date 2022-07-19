#!/usr/bin/env nextflow


nextflow.enable.dsl=2


process split_csv {
    publishDir "${workflow.projectDir}/publishDir/", mode:'copy', pattern: '*.png'

    input:
        val(data_directory)

    output:
        path '*.csv', emit: csv_out
        // For somthing to appear in publishDir it must be added as an output as well.
        path '*.png', emit: png_scatter

    script:
        """
        Rscript ${workflow.projectDir}/custom_scripts/plot_and_split_by_IQ.R -d '$data_directory'
        """
}


process write_sentence_txt_files {

    input:
        val(csv_file)

    output:
        path '*.txt', emit: txt_out

    script:
        """
        python ${workflow.projectDir}/custom_scripts/make_sentences.py -d '$csv_file'
        """
}




dir = "/ahg/regevdata/projects/lungCancerBueno/Results/10x_nsclc_41421/data/PRIV_GITHUB/NF_IQ/csvData.csv"
split_csv_input = Channel.of(dir)


workflow {
    split_csv(split_csv_input)
    write_sentence_txt_files(split_csv.out.csv_out)
}
