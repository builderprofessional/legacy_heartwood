<?php   // In whatever file you include this, set the variable "$this->colorpickerInitColor" to the starting color desired for the picker. You should also set the hidden field that holds the color value to the initial color too. ?>
        <script type="text/javascript"> var root = "<?=$this->rootDir ?>"; </script>
        <script type="text/javascript" src="<?= $this->rootDir ?>modules/includes/refresh_web/prototype.js" ></script>
        <script type="text/javascript" src="<?= $this->rootDir ?>modules/includes/refresh_web/colorpicker/colormethods.js" ></script>
        <script type="text/javascript" src="<?= $this->rootDir ?>modules/includes/refresh_web/colorpicker/colorvaluepicker.js" ></script>
        <script type="text/javascript" src="<?= $this->rootDir ?>modules/includes/refresh_web/colorpicker/slider.js" ></script>
        <script type="text/javascript" src="<?= $this->rootDir ?>modules/includes/refresh_web/colorpicker/colorpicker.js" ></script>

        <table>
            <tr>
                <td valign="top" style="position:relative;">
                    <div id="cp1_ColorMap"></div>
                </td>
                <td valign="top" style="position:relative;">
                    <div id="cp1_ColorBar"></div>
                </td>
    
                <td valign="top">
    
                    <table>
                        <tr>
                            <td colspan="3">
                                <div id="cp1_Preview" style="background-color: #fff; width: 60px; height: 60px; padding: 0; margin: 0; border: solid 1px #000;">
                                    <br />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="radio" id="cp1_HueRadio" name="cp1_Mode" value="0" />
                            </td>
                            <td>
                                <label for="cp1_HueRadio">H:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Hue" value="0" style="width: 40px;" /> &deg;
                            </td>
                        </tr>
    
                        <tr>
                            <td>
                                <input type="radio" id="cp1_SaturationRadio" name="cp1_Mode" value="1" />
                            </td>
                            <td>
                                <label for="cp1_SaturationRadio">S:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Saturation" value="100" style="width: 40px;" /> %
                            </td>
                        </tr>
    
                        <tr>
                            <td>
                                <input type="radio" id="cp1_BrightnessRadio" name="cp1_Mode" value="2" />
                            </td>
                            <td>
                                <label for="cp1_BrightnessRadio">B:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Brightness" value="100" style="width: 40px;" /> %
                            </td>
                        </tr>
    
                        <tr>
                            <td colspan="3" height="5">
    
                            </td>
                        </tr>
    
                        <tr>
                            <td>
                                <input type="radio" id="cp1_RedRadio" name="cp1_Mode" value="r" />
                            </td>
                            <td>
                                <label for="cp1_RedRadio">R:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Red" value="255" style="width: 40px;" />
                            </td>
                        </tr>
    
                        <tr>
                            <td>
                                <input type="radio" id="cp1_GreenRadio" name="cp1_Mode" value="g" />
                            </td>
                            <td>
                                <label for="cp1_GreenRadio">G:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Green" value="0" style="width: 40px;" />
                            </td>
                        </tr>
    
                        <tr>
                            <td>
                                <input type="radio" id="cp1_BlueRadio" name="cp1_Mode" value="b" />
                            </td>
                            <td>
                                <label for="cp1_BlueRadio">B:</label>
                            </td>
                            <td>
                                <input type="text" id="cp1_Blue" value="0" style="width: 40px;" />
                            </td>
                        </tr>
    
    
                        <tr>
                            <td>
                                #:
                            </td>
                            <td colspan="2">
                                <input type="text" id="cp1_Hex" value="<?=$this->colorpickerInitColor?>" style="width: 60px;" />
                            </td>
                        </tr>
    
                    </table>
                </td>
            </tr>
        </table>
        
    
    <div style="display:none;">
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/rangearrows.gif" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/mappoint.gif" />
        
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-saturation.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-brightness.png" />
        
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-blue-tl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-blue-tr.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-blue-bl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-blue-br.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-red-tl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-red-tr.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-red-bl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-red-br.png" />    
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-green-tl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-green-tr.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-green-bl.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/bar-green-br.png" />
        
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-red-max.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-red-min.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-green-max.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-green-min.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-blue-max.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-blue-min.png" />
        
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-saturation.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-saturation-overlay.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-brightness.png" />
        <img src="<?=$this->rootDir?>modules/includes/refresh_web/colorpicker/images/map-hue.png" />
        
        
        
    </div>
    <script type="text/javascript">
        
        Event.observe(window,'load',function() {
            cp1 = new Refresh.Web.ColorPicker('cp1',{startHex:'<?=$this->colorpickerInitColor?>', startMode:'s', clientFilesPath:'<?=$this->rootDir?>/modules/includes/refresh_web/colorpicker/images/'});
            cp1._cvp._saturationInput.value = 100;
            cp1._cvp.color.s = 100;
            cp1.textValuesChanged();
            cp1.bgChanged=colorChangeEvent;
        });
        
        
    </script>
