#!/bin/bash
# Buat DraCoola
# Moving ke Sempak, biar semua server sempakan

read bekapan
what="/home/$bekapan"
echo chown sempak:sempak $what;
echo chmod 644 $what;
echo mv $what /home/sempak/public_html;