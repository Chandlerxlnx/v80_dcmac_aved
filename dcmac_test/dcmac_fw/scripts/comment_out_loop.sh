sed '/set_gt_pcs_loopback_and_reset_static/,/}/{
        /\/\/ Setting NE PCS loopback/ {
            N
            s/\(.*\)\n\(.*\)/\1\n\/\/ \2/
            N
            s/\(.*\)\n\(.*\)/\1\n\/\/ \2/
            N
            s/\(.*\)\n\(.*\)/\1\n\/\/ \2/
        }
    }' $@
