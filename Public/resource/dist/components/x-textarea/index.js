!function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t():"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?exports.vuxXTextarea=t():e.vuxXTextarea=t()}(this,function(){return function(e){function t(o){if(n[o])return n[o].exports;var i=n[o]={exports:{},id:o,loaded:!1};return e[o].call(i.exports,i,i.exports,t),i.loaded=!0,i.exports}var n={};return t.m=e,t.c=n,t.p="",t(0)}([function(e,t,n){e.exports=n(6)},function(e,t,n){"use strict";function o(e){return e&&e.__esModule?e:{"default":e}}Object.defineProperty(t,"__esModule",{value:!0});var i=n(2),r=o(i);t["default"]={minxins:[r["default"]],props:{showCounter:{type:Boolean,"default":!0},max:Number,value:{type:String,"default":"",twoWay:!0},name:String,placeholder:{type:String,"default":""},rows:{type:Number,"default":3},cols:{type:Number,"default":30},height:Number},watch:{value:function(e){this.max&&this.value.length>this.max&&(this.value=e.slice(0,this.max)),this.$emit("on-change",this.value)}},computed:{count:function(){return this.value.length},textareaStyle:function(){if(this.height)return{height:this.height+"px"}}}}},function(e,t,n){"use strict";function o(e){return e&&e.__esModule?e:{"default":e}}Object.defineProperty(t,"__esModule",{value:!0});var i=n(3),r=o(i);t["default"]={mixins:[r["default"]],props:{required:{type:Boolean,"default":!0}},created:function(){this.handleChangeEvent=!1},computed:{dirty:function(){return!this.prisine},invalid:function(){return!this.valid}},methods:{setTouched:function(){this.touched=!0}},watch:{value:function(e){this.prisine===!0&&(this.prisine=!1),this.handleChangeEvent||this.$emit("change",e)}},data:function(){return{errors:{},prisine:!0,touched:!1,valid:!0}}}},function(e,t){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),t["default"]={created:function(){this.uuid=Math.random().toString(36).substring(3,8)}}},function(e,t){},function(e,t){e.exports=' <div class=weui_cell> <div class="weui_cell_bd weui_cell_primary"> <textarea class=weui_textarea placeholder={{placeholder}} :name=name :rows=rows :cols=cols v-model=value :style=textareaStyle :maxlength=max></textarea> <div class=weui_textarea_counter v-show="showCounter && max"><span>{{count}}</span>/{{max}}</div> </div> </div> '},function(e,t,n){var o,i;n(4),o=n(1),i=n(5),e.exports=o||{},e.exports.__esModule&&(e.exports=e.exports["default"]),i&&(("function"==typeof e.exports?e.exports.options||(e.exports.options={}):e.exports).template=i)}])});