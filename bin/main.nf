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




// process create_final_file {
//     """
//     touch ${workflow.workDir}/final.txt
//     """
// }


// process cat_txt_files {

//     input:
//         path '*.txt'

//     script:
//         """
//         cat *.txt >> ${workflow.workDir}/final.txt
//         """
// }

process foo {
    input:
        path x

    script:
        """
        cat $x >> final.txt
        """
}


workflow {
    split_csv_input = Channel.of(params.dir)
    split_csv(split_csv_input)
    //  the output of the above process gives somthing like this ['path/nimber/one', 'path/number/two'...] I need to flatten this output.
    write_sentence_txt_files(split_csv.out.csv_out.flatten())
    channel_out = write_sentence_txt_files.out.txt_out.collectFile()
    foo(channel_out.flatten())

    // create_final_file()
    // cat_txt_files(write_sentence_txt_files.out.txt_out.collect())

}
