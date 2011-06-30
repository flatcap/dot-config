#!/usr/bin/php
<?php

for ($i = 2001; $i <= 2010; $i++) {
  echo date("Y_m_d l", easter_date($i));
  echo "\n";
}

