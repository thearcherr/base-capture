dofile("decui/decui.nut"); /* Loading DecUI */
include("main_mem.nut"); /* Loading the main file */

function Script::ScriptLoad() {
}
function Script::ScriptProcess(){
    UI.events.scriptProcess();
}
function KeyBind::OnDown(keyBind) {
    UI.events.onKeyDown(keyBind);
}
function KeyBind::OnUp(keyBind) {
    UI.events.onKeyUp(keyBind);
}
function GUI::ElementClick(element, mouseX, mouseY){
    UI.events.onClick(element,mouseX,mouseY); 
} 
function GUI::ElementFocus(element){
    UI.events.onFocus(element);
}
function GUI::ElementBlur(element) {
    UI.events.onBlur(element); 
}
function GUI::ElementHoverOver(element) {
    UI.events.onHoverOver(element);
}
function GUI::ElementHoverOut(element){
    UI.events.onHoverOut(element);
}
function GUI::ElementRelease(element, mouseX, mouseY){
    UI.events.onRelease(element, mouseX, mouseY);
}
function GUI::ElementDrag(element, mouseX, mouseY) {
    UI.events.onDrag(element, mouseX, mouseY);
}
function GUI::CheckboxToggle(checkbox, checked)  {
    UI.events.onCheckboxToggle(checkbox, checked);
}
function GUI::WindowClose(window) {
    UI.events.onWindowClose(window);
}
function GUI::InputReturn(editbox) {
    UI.events.onInputReturn(editbox);
}
function GUI::ListboxSelect(listbox, text) {
    UI.events.onListboxSelect(listbox,text);
}
function GUI::ScrollbarScroll(scrollbar, position, change) {
    UI.events.onScrollbarScroll(scrollbar, position,change);
}
function GUI::GameResize(width, height) {
   UI.events.onGameResize();

}
function GUI::WindowResize(window, width, height) {
    UI.events.onWindowResize(window, width, height);
}
