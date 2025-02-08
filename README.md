# AquaLens - Water Quality Monitoring App

AquaLens is a flutter-based Android application designed to measure water quality parameters such as Suspended Particulate Matter (SPM) and Turbidity using citizen science and remote sensing technologies. This app empowers users to contribute to environmental monitoring by collecting and analyzing water quality data.

## **Screenshots**
<div align="center">
  <img src="assets/images/img1.png" width="200" style="margin: 10px;">
  <img src="assets/images/img2.png" width="200" style="margin: 10px;">
</div>

<div align="center">
  <div class="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
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
    </div>
    <button class="carousel-control prev" onclick="prevSlide()">&#10094;</button>
    <button class="carousel-control next" onclick="nextSlide()">&#10095;</button>
  </div>
</div>

<style>
  .carousel {
    position: relative;
    max-width: 600px;
    margin: auto;
    overflow: hidden;
    border: 2px solid #ddd;
    border-radius: 10px;
  }

  .carousel-inner {
    display: flex;
    transition: transform 0.5s ease-in-out;
  }

  .carousel-item {
    min-width: 100%;
    box-sizing: border-box;
  }

  .carousel-item img {
    width: 200px;
    display: block;
    border-radius: 10px;
  }

  .carousel-control {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
    font-size: 18px;
  }

  .carousel-control.prev {
    left: 10px;
  }

  .carousel-control.next {
    right: 10px;
  }

  .carousel-control:hover {
    background-color: rgba(0, 0, 0, 0.8);
  }
</style>

<script>
  let currentIndex = 0;

  function showSlide(index) {
    const carouselInner = document.querySelector('.carousel-inner');
    const totalItems = document.querySelectorAll('.carousel-item').length;
    if (index >= totalItems) currentIndex = 0;
    if (index < 0) currentIndex = totalItems - 1;
    carouselInner.style.transform = `translateX(-${currentIndex * 100}%)`;
  }

  function nextSlide() {
    currentIndex++;
    showSlide(currentIndex);
  }

  function prevSlide() {
    currentIndex--;
    showSlide(currentIndex);
  }

  // Optional: Auto-play the carousel
  setInterval(nextSlide, 3000); // Change slide every 3 seconds
</script>



  


