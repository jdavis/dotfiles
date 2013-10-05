if ($^O == 'darwin') {
    # Open Skim when using OS X
    $pdf_previewer = "open -a Skim.app";
} else {
    # Open Mint's default pdf viewers
    $pdf_previewer = "mate-open";
}
