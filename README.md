# AquaLens - Water Quality Monitoring App

AquaLens is a flutter-based Android application designed to measure water quality parameters such as Suspended Particulate Matter (SPM) and Turbidity using citizen science and remote sensing technologies. This app empowers users to contribute to environmental monitoring by collecting and analyzing water quality data.

## **Screenshots**

https://umer-saleem.github.io/aqua-sense/screenshots.html

## **Screenshots**
<div align="center">
  <div class="carousel">
    <div class="carousel-inner">
      <input type="radio" name="carousel" id="slide1" checked>
      <input type="radio" name="carousel" id="slide2">
      <input type="radio" name="carousel" id="slide3">
      <input type="radio" name="carousel" id="slide4">
      <input type="radio" name="carousel" id="slide5">
      <input type="radio" name="carousel" id="slide6">
      <input type="radio" name="carousel" id="slide7">
      <input type="radio" name="carousel" id="slide8">
      <div class="carousel-items">
        <div class="carousel-item">
          <img src="assets/images/img1.png" alt="Screen 1">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img2.png" alt="Screen 2">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img3.png" alt="Screen 3">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img4.png" alt="Screen 4">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img5.png" alt="Screen 5">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img6.png" alt="Screen 6">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img7.png" alt="Screen 7">
        </div>
        <div class="carousel-item">
          <img src="assets/images/img8.png" alt="Screen 8">
        </div>
      </div>
      <div class="carousel-nav">
        <label for="slide1" class="nav-dot"></label>
        <label for="slide2" class="nav-dot"></label>
        <label for="slide3" class="nav-dot"></label>
        <label for="slide4" class="nav-dot"></label>
        <label for="slide5" class="nav-dot"></label>
        <label for="slide6" class="nav-dot"></label>
        <label for="slide7" class="nav-dot"></label>
        <label for="slide8" class="nav-dot"></label>
      </div>
    </div>
  </div>
</div>

<style>
  .carousel {
    max-width: 600px;
    margin: auto;
    overflow: hidden;
    border: 2px solid #ddd;
    border-radius: 10px;
    position: relative;
  }

  .carousel-inner {
    display: flex;
    transition: transform 0.5s ease-in-out;
  }

  .carousel-items {
    display: flex;
    width: 800%;
  }

  .carousel-item {
    flex: 1 0 100%;
    box-sizing: border-box;
  }

  .carousel-item img {
    width: 100%;
    display: block;
    border-radius: 10px;
  }

  .carousel-nav {
    text-align: center;
    margin-top: 10px;
  }

  .nav-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    background-color: #bbb;
    border-radius: 50%;
    margin: 0 5px;
    cursor: pointer;
  }

  .nav-dot:hover {
    background-color: #777;
  }

  input[type="radio"] {
    display: none;
  }

  #slide1:checked ~ .carousel-items {
    transform: translateX(0%);
  }

  #slide2:checked ~ .carousel-items {
    transform: translateX(-100%);
  }

  #slide3:checked ~ .carousel-items {
    transform: translateX(-200%);
  }

  #slide4:checked ~ .carousel-items {
    transform: translateX(-300%);
  }

  #slide5:checked ~ .carousel-items {
    transform: translateX(-400%);
  }

  #slide6:checked ~ .carousel-items {
    transform: translateX(-500%);
  }

  #slide7:checked ~ .carousel-items {
    transform: translateX(-600%);
  }

  #slide8:checked ~ .carousel-items {
    transform: translateX(-700%);
  }
</style>



  


